using Microsoft.EntityFrameworkCore;

public class GetAllOtherCarOrderQuery
{
    private readonly IUserDbContext _context;
    

    public GetAllOtherCarOrderQuery(IUserDbContext context)
    {
        _context = context;
    }

    public async Task<List<OtherCarOrder>> Handle()
    {
        var dbOtherOrders = await _context.OtherCarOrders.Include(u=>u.Car).ToListAsync();
        if(dbOtherOrders is null)
        {
            throw new InvalidOperationException("Bu Sipariş Mevcut Değil");
        }
        return  dbOtherOrders;
    }
}