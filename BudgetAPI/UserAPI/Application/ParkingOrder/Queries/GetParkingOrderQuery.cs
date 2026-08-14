using Microsoft.EntityFrameworkCore;

public class GetParkingOrderQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetParkingOrderQuery(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task<ParkingOrder> Handle()
    {
        var dbParkingOrder = await _context.ParkingOrders.Include(u=>u.Car).FirstOrDefaultAsync(x=>x.Car_id == _id);
        if(dbParkingOrder is null)
        {
            throw new InvalidOperationException("Park Faturası Mevcut Değil!");
        }
        return dbParkingOrder;
    }
}