using Microsoft.EntityFrameworkCore;

public class UpdateFoodOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly UpdateFoodOrderModel _model;
    private readonly int _id;

    public UpdateFoodOrderCommand(IUserDbContext context, UpdateFoodOrderModel model, int id)
    {
        _context = context;
        _model = model;
        _id = id;
    }

    public async Task Handle()
    {
        var dbFoodOrder = await _context.FoodOrders.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbFoodOrder is null)
        {
            throw new InvalidOperationException("Yemek Kaydı Yok!");
        }
        dbFoodOrder.Food_name = _model.Food_name;
        dbFoodOrder.Price = _model.Price;
        dbFoodOrder.User_id = _model.User_id;
        dbFoodOrder.Restaurant = _model.Restaurant;
        dbFoodOrder.UpdatedAt = DateTime.UtcNow;
        _context.FoodOrders.Update(dbFoodOrder);
        await _context.SaveChangesAsync();
    }
}

public class UpdateFoodOrderModel
{
    public UpdateFoodOrderModel()
    {
        
    }
    public UpdateFoodOrderModel(int user_id, string? food_name, decimal? price, string? restaurant)
    {
        User_id = user_id;
        Food_name = food_name;
        Price = price;
        Restaurant = restaurant;
    }

    public int User_id { get; set; }
    public string? Food_name { get; set; }
    public decimal? Price { get; set; }
    public string? Restaurant { get; set; }
}