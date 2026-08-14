using Microsoft.EntityFrameworkCore;

public class CreateParkingOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly CreateParkingOrderModel _model;

    public CreateParkingOrderCommand(IUserDbContext context, CreateParkingOrderModel model)
    {
        _context = context;
        _model = model;
    }

    public async Task Handle()
    {
        var dbParkingOrder = await _context.ParkingOrders.FirstOrDefaultAsync(x=>x.Car_id == _model.Car_id && x.Total_price == _model.Total_price);
        if(dbParkingOrder is not null)
        {
            throw new InvalidOperationException("Park Faturası Zaten Mevcut!");
        }
        var Parking_order = new ParkingOrder();
        Parking_order.User_id = _model.User_id;
        Parking_order.Car_id = _model.Car_id;
        Parking_order.Parking_name = _model.Parking_name;
        Parking_order.Total_price = _model.Total_price;
        Parking_order.Hour_price = _model.Hour_price;
        Parking_order.Hour = _model.Hour;
        Parking_order.Free_hour = _model.Free_hour;
        Parking_order.Payment_type = _model.Payment_type;
        Parking_order.CreatedAt = DateTime.UtcNow;
        await _context.ParkingOrders.AddAsync(Parking_order);
        await _context.SaveChangesAsync();
    }
}

public class CreateParkingOrderModel
{
    public CreateParkingOrderModel()
    {
        
    }
    public CreateParkingOrderModel(int user_id, int car_id, string? parking_name, decimal? total_price, decimal? hour_price, decimal? hour, decimal? free_hour, Payment? payment_type)
    {
        User_id = user_id;
        Car_id = car_id;
        Parking_name = parking_name;
        Total_price = total_price;
        Hour_price = hour_price;
        Hour = hour;
        Free_hour = free_hour;
        Payment_type = payment_type;
    }

    public int User_id { get; set; }
    public int Car_id { get; set; } 
    public string? Parking_name { get; set; }
    public decimal? Total_price { get; set; }
    public decimal? Hour_price { get; set; }
    public decimal? Hour { get; set; }
    public decimal? Free_hour { get; set; }
    public Payment? Payment_type { get; set; }
}