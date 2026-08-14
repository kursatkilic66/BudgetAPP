using Microsoft.EntityFrameworkCore;

public class GetCarItemQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetCarItemQuery(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task<CarItem> Handle()
    {
        var dbCarItem = await _context.CarItems.Include(u=>u.User).Include(u=>u.Car).FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbCarItem is null)
        {
            throw new InvalidOperationException("Araç mevcut değil!");
        }
        return dbCarItem;
    }

    
}