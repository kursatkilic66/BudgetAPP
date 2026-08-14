using Microsoft.EntityFrameworkCore;

public class GetFuelOrderQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetFuelOrderQuery(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task<FuelOrder> Handle()
    {
        var dbFuel = await _context.FuelOrders.Include(u=>u.Car).Include(u=>u.User).FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbFuel is null)
        {
            throw new InvalidOperationException("Akaryakıt İşlemi Mevcut Değil!");
        }
        return dbFuel;
    }
}