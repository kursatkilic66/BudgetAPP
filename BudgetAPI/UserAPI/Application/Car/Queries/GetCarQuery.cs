using Microsoft.EntityFrameworkCore;

public class GetCarQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetCarQuery(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task<Car> Handle()
    {
        var dbCar = await _context.Cars.Include(u=> u.Owner).Include(u=>u.CarItems).FirstOrDefaultAsync(x=> x.Id == _id) ;
        if(dbCar is null)
        {
            throw new InvalidOperationException("Araç mevcut değil!");
        }
        return dbCar;
    }
}