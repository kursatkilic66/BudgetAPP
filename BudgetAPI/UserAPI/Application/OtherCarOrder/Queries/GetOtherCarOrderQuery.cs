using Microsoft.EntityFrameworkCore;

public class GetOtherCarOrderQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetOtherCarOrderQuery(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task<OtherCarOrder> Handle()
    {
        var dbOtherOrder = await _context.OtherCarOrders.Include(u=>u.Car).FirstOrDefaultAsync(x=>x.User_id == _id);
        if(dbOtherOrder is null)
        {
            throw new InvalidOperationException("Bu Sipariş Mevcut Değil");
        }
        return  dbOtherOrder;
    }
}