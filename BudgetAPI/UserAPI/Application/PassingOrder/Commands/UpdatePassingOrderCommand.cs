using Microsoft.EntityFrameworkCore;

public class UpdatePassingOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly UpdatePassingOrderModel _model;
    private readonly int _id;

    public UpdatePassingOrderCommand(IUserDbContext context, UpdatePassingOrderModel model, int id)
    {
        _context = context;
        _model = model;
        _id = id;
    }

    public async Task Handle()
    {
        var dbPassingOrder = await _context.PassingOrders.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbPassingOrder is null)
        {
            throw new InvalidOperationException("Geçiş Mevcut Değil!");
        }
        dbPassingOrder.User_id = _model.User_id;
        dbPassingOrder.Car_id = _model.Car_id;
        dbPassingOrder.Name = _model.Name;
        dbPassingOrder.Price = _model.Price;
        dbPassingOrder.Payment_type = _model.Payment_type;
        dbPassingOrder.UpdatedAt = DateTime.UtcNow;
        _context.PassingOrders.Update(dbPassingOrder);
        await _context.SaveChangesAsync();
    }

    public class UpdatePassingOrderModel
    {
        public UpdatePassingOrderModel()
        {
            
        }
        public UpdatePassingOrderModel(int? user_id, int? car_id, string? name, decimal? price, Payment? payment_type)
        {
            User_id = user_id;
            Car_id = car_id;
            Name = name;
            Price = price;
            Payment_type = payment_type;
        }

        public int? User_id { get; set; }
        public int? Car_id { get; set; }
        public string? Name { get; set; }
        public decimal? Price { get; set; }
        public Payment? Payment_type { get; set; }
    }
}