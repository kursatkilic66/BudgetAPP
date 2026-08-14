using Microsoft.EntityFrameworkCore;

public class DeleteOtherCarOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public DeleteOtherCarOrderCommand(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task Handle()
    {
        var dbOtherOrder = await _context.OtherCarOrders.FirstOrDefaultAsync(x=>x.User_id == _id);
        if(dbOtherOrder is null)
        {
            throw new InvalidOperationException("Bu Sipariş Zaten Mevcut Değil");
        }
        _context.OtherCarOrders.Remove(dbOtherOrder);
        await _context.SaveChangesAsync();
    }
}