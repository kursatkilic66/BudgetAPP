using Microsoft.EntityFrameworkCore;

public class GetAllPassingOrderQuery
{
    private readonly IUserDbContext _context;

    public GetAllPassingOrderQuery(IUserDbContext context)
    {
        _context = context;
    }

    public async Task<List<PassingOrder>> Handle()
    {
        var dbPassingOrders = await _context.PassingOrders.Include(u=>u.Car).ToListAsync();
        if(dbPassingOrders is null)
        {
            throw new InvalidOperationException("Geçiş Zaten Mevcut Değil!");
        }
        return dbPassingOrders;
    }
}