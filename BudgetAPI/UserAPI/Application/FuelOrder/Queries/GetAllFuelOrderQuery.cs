using Microsoft.EntityFrameworkCore;

public class GetAllFuelOrderQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetAllFuelOrderQuery(IUserDbContext context)
    {
        _context = context;
    }

    public async Task<List<FuelOrder>> Handle()
    {
        var dbFuels = await _context.FuelOrders.Include(u=>u.Car).Include(u=>u.User).ToListAsync();
        if(dbFuels is null)
        {
            throw new InvalidOperationException("Akaryakıt İşlemi Mevcut Değil!");
        }
        return dbFuels;
    }
}