using Microsoft.EntityFrameworkCore;

public class GetAllCarItemQuery
{
    private readonly IUserDbContext _context;

    public GetAllCarItemQuery(IUserDbContext context)
    {
        _context = context;
    }

    public async Task<List<CarItem>> Handle()
    {
        var dbCarItems = await _context.CarItems.Include(u=>u.User).Include(u=>u.Car).ToListAsync();
        if(dbCarItems is null)
        {
            throw new InvalidOperationException("Araç mevcut değil!");
        }
        return dbCarItems;
    }
}