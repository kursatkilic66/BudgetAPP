using Microsoft.EntityFrameworkCore;

public class GetAllCarsQuery
{
    private readonly IUserDbContext _context;

    public GetAllCarsQuery(IUserDbContext context)
    {
        _context = context;
    }

    public async Task<List<Car>> Handle()
    {
        var dbCars = await _context.Cars.Include(u=> u.Owner).Include(u=>u.CarItems).ToListAsync();
        if(dbCars is null)
        {
            throw new InvalidOperationException("Araç mevcut değil!");
        }
        return dbCars;
    }
}