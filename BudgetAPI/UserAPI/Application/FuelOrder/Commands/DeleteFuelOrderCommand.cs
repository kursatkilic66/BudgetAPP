using Microsoft.EntityFrameworkCore;

public class DeleteFuelOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public DeleteFuelOrderCommand(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task Handle()
    {
        var dbFuel = await _context.FuelOrders.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbFuel is null)
        {
            throw new InvalidOperationException("Akaryakıt İşlemi Zaten Mevcut Değil!");
        }
        _context.FuelOrders.Remove(dbFuel);
        await _context.SaveChangesAsync();
    }
}