using Microsoft.EntityFrameworkCore;

public class GetAllTransportationOrderQuery
{
    private readonly IUserDbContext _context;

    public GetAllTransportationOrderQuery(IUserDbContext context)
    {
        _context = context;
    }

    public async Task<List<TransportationOrder>> Handle()
    {
        var dbItems = await _context.TransportationOrders.ToListAsync();
        if(dbItems is null)
        {
            throw new InvalidOperationException("Böyle bir harcama yok!");
        }
        return dbItems; 
    }
}