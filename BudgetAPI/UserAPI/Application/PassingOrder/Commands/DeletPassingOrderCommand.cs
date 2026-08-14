using Microsoft.EntityFrameworkCore;

public class DeletPassingOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public DeletPassingOrderCommand(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task Handle()
    {
        var dbPassingOrder = await _context.PassingOrders.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbPassingOrder is null)
        {
            throw new InvalidOperationException("Geçiş Zaten Mevcut Değil!");
        }
        _context.PassingOrders.Remove(dbPassingOrder);
        await _context.SaveChangesAsync();
    }
}