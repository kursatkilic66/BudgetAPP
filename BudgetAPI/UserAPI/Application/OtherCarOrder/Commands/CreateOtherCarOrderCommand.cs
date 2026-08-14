using Microsoft.EntityFrameworkCore;

public class CreateOtherCarOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly CreateOtherCarOrderModel _model;

    public CreateOtherCarOrderCommand(IUserDbContext context, CreateOtherCarOrderModel model)
    {
        _context = context;
        _model = model;
    }

    public async Task Handle()
    {
        var dbOtherOrder = await _context.OtherCarOrders.FirstOrDefaultAsync(x=>x.User_id == _model.User_id && x.Name == _model.Name && x.Price == _model.Price);
        if(dbOtherOrder is not null)
        {
            throw new InvalidOperationException("Bu Sipariş Zaten Mevcut");
        }
        var Other_order = new OtherCarOrder();
        Other_order.User_id = _model.User_id;
        Other_order.Car_id = _model.Car_id;
        Other_order.Name = _model.Name;
        Other_order.Price = _model.Price;
        Other_order.CreatedAt = DateTime.UtcNow;
        await _context.OtherCarOrders.AddAsync(Other_order);
        await _context.SaveChangesAsync();
    }
}

public class CreateOtherCarOrderModel
{
    public CreateOtherCarOrderModel()
    {
        
    }
    public CreateOtherCarOrderModel(int? user_id, int? car_id, string? name, decimal? price)
    {
        User_id = user_id;
        Car_id = car_id;
        Name = name;
        Price = price;
    }

    public int? User_id { get; set; }
    public int? Car_id { get; set; }
    public string? Name { get; set; }
    public decimal? Price { get; set; }
}