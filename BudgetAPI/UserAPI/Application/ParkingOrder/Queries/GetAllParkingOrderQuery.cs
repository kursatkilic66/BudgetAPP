using Microsoft.EntityFrameworkCore;

public class GetAllParkingOrderQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetAllParkingOrderQuery(IUserDbContext context)
    {
        _context = context;
    }

    public async Task<List<ParkingOrder>> Handle()
    {
        var dbParkingOrders = await _context.ParkingOrders.Include(u=>u.Car).ToListAsync();
        if(dbParkingOrders is null)
        {
            throw new InvalidOperationException("Park Faturası Mevcut Değil!");
        }
        return dbParkingOrders;
    }
}