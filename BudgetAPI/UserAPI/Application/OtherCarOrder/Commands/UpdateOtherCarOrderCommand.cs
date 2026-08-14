using Microsoft.EntityFrameworkCore;

public class UpdateOtherCarOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly UpdateOtherCarOrderModel _model;
    private readonly int _id;

    public UpdateOtherCarOrderCommand(IUserDbContext context, UpdateOtherCarOrderModel model, int id)
    {
        _context = context;
        _model = model;
        _id = id;
    }

    public async Task Handle()
    {
        var dbOtherOrder = await _context.OtherCarOrders.FirstOrDefaultAsync(x=>x.User_id == _id);
        if(dbOtherOrder is null)
        {
            throw new InvalidOperationException("Bu Sipariş Mevcut Değil");
        }
        dbOtherOrder.User_id = _model.User_id;
        dbOtherOrder.Car_id = _model.Car_id;
        dbOtherOrder.Price = _model.Price;
        dbOtherOrder.Name = _model.Name;
        dbOtherOrder.UpdatedAt = DateTime.UtcNow;
        _context.OtherCarOrders.Update(dbOtherOrder);
        await _context.SaveChangesAsync();
    }
}

public class UpdateOtherCarOrderModel
{
    public UpdateOtherCarOrderModel()
    {
        
    }
    public UpdateOtherCarOrderModel(int? user_id, int? car_id, string? name, decimal? price)
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