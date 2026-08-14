using Microsoft.EntityFrameworkCore;

public class CreatePassingOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly CreatePassingOrderModel _model;

    public CreatePassingOrderCommand(IUserDbContext context, CreatePassingOrderModel model)
    {
        _context = context;
        _model = model;
    }
    public async Task Handle()
    {
        var dbPassingOrder = await _context.PassingOrders.FirstOrDefaultAsync(x=>x.Car_id == _model.Car_id && x.Price == _model.Price);
        if(dbPassingOrder is not null)
        {
            throw new InvalidOperationException("Geçiş Zaten Mevcut!");
        }
        var Passing_order = new PassingOrder();
        Passing_order.User_id = _model.User_id;
        Passing_order.Car_id = _model.Car_id;
        Passing_order.Name = _model.Name;
        Passing_order.Price = _model.Price;
        Passing_order.Payment_type = _model.Payment_type;
        Passing_order.CreatedAt = DateTime.UtcNow;
        await _context.PassingOrders.AddAsync(Passing_order);
        await _context.SaveChangesAsync();
    }



    public class CreatePassingOrderModel
    {
        public CreatePassingOrderModel()
        {
            
        }
        public CreatePassingOrderModel(int? user_id, int? car_id, string? name, decimal? price, Payment? payment_type)
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