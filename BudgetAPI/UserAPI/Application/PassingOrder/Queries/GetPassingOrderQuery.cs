using Microsoft.EntityFrameworkCore;

public class GetPassingOrderQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetPassingOrderQuery(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task<PassingOrder> Handle()
    {
        var dbPassingOrder = await _context.PassingOrders.Include(u=>u.Car).FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbPassingOrder is null)
        {
            throw new InvalidOperationException("Geçiş Zaten Mevcut Değil!");
        }
        return dbPassingOrder;
    }
}