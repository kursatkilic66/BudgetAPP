using Microsoft.EntityFrameworkCore;

public class DeleteParkingOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public DeleteParkingOrderCommand(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task Handle()
    {
        var dbParkingOrder = await _context.ParkingOrders.FirstOrDefaultAsync(x=>x.Car_id == _id);
        if(dbParkingOrder is null)
        {
            throw new InvalidOperationException("Park Faturası Zaten Mevcut Değil!");
        }
        _context.ParkingOrders.Remove(dbParkingOrder);
        await _context.SaveChangesAsync();
    }
}