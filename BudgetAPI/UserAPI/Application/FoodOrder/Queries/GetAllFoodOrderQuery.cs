using Microsoft.EntityFrameworkCore;

public class GetAllFoodOrderQuery
{
    private readonly IUserDbContext _context;

    public GetAllFoodOrderQuery(IUserDbContext context)
    {
        _context = context;
    }

    public async Task<List<FoodOrder>> Handle()
    {
        var dbFoodOrders = await _context.FoodOrders.Include(u=>u.User).ToListAsync();
        if(dbFoodOrders is null)
        {
            throw new InvalidOperationException("Yemek Kaydı Yok!");
        }
        return dbFoodOrders;
    }
}