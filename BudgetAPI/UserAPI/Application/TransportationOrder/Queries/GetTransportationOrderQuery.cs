using Microsoft.EntityFrameworkCore;

public class GetTransportationOrderQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetTransportationOrderQuery(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task<TransportationOrder> Handle()
    {
        var dbItem = await _context.TransportationOrders.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbItem is null)
        {
            throw new InvalidOperationException("Böyle bir harcama yok!");
        }
        return  dbItem; 
    }
}