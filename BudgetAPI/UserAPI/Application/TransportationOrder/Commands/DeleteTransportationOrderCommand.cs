using Microsoft.EntityFrameworkCore;

public class DeleteTransportationOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public DeleteTransportationOrderCommand(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task Handle()
    {
        var dbItem = await _context.TransportationOrders.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbItem is null)
        {
            throw new InvalidOperationException("Böyle bir harcama zaten yok!");
        }
        _context.TransportationOrders.Remove(dbItem);
        await _context.SaveChangesAsync();
    }
}