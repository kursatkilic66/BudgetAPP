using Microsoft.EntityFrameworkCore;

public class GetFoodOrderQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetFoodOrderQuery(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task<FoodOrder> Handle()
    {
        var dbFoodOrder = await _context.FoodOrders.Include(u=>u.User).FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbFoodOrder is null)
        {
            throw new InvalidOperationException("Yemek Kaydı Yok!");
        }
        return dbFoodOrder;
    }
}