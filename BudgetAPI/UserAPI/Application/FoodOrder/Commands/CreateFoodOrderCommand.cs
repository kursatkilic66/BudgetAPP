using Microsoft.EntityFrameworkCore;

public class CreateFoodOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly CreateFoodOrderModel _model;

    public CreateFoodOrderCommand(IUserDbContext context, CreateFoodOrderModel model)
    {
        _context = context;
        _model = model;
    }

    public async Task Handle()
    {
        var dbFoodOrder = await _context.FoodOrders.FirstOrDefaultAsync(x=>x.Price == _model.Price && x.Restaurant == _model.Restaurant);
        if(dbFoodOrder is not null)
        {
            throw new InvalidOperationException("Yemek zaten eklenmiş!");
        }
        var food = new FoodOrder();
        food.Food_name = _model.Food_name;
        food.Price = _model.Price;
        food.User_id = _model.User_id;
        food.Restaurant = _model.Restaurant;
        await _context.FoodOrders.AddAsync(food);
        await _context.SaveChangesAsync();
    }

    public class CreateFoodOrderModel
    {
        public CreateFoodOrderModel()
        {
            
        }
        public CreateFoodOrderModel(int user_id, string? food_name, decimal? price, string? restaurant)
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
}