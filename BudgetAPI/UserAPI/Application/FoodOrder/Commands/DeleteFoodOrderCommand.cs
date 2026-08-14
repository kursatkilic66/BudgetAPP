using Microsoft.EntityFrameworkCore;

public class DeleteFoodOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public DeleteFoodOrderCommand(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task Handle()
    {
        var dbFoodOrder = await _context.FoodOrders.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbFoodOrder is null)
        {
            throw new InvalidOperationException("Yemek Kaydı Zaten Yok!");
        }
        _context.FoodOrders.Remove(dbFoodOrder);
        await _context.SaveChangesAsync();
    }
}