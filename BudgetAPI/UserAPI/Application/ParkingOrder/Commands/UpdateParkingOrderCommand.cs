using Microsoft.EntityFrameworkCore;

public class UpdateParkingOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly UpdateParkingOrderModel _model;
    private readonly int _id;

    public UpdateParkingOrderCommand(IUserDbContext context, UpdateParkingOrderModel model, int id)
    {
        _context = context;
        _model = model;
        _id = id;
    }

    public async Task Handle()
    {
        var dbParkingOrder = await _context.ParkingOrders.FirstOrDefaultAsync(x=>x.Car_id == _id);
        if(dbParkingOrder is null)
        {
            throw new InvalidOperationException("Park Faturası Mevcut Değil!");
        }
        dbParkingOrder.User_id = _model.User_id;
        dbParkingOrder.Car_id = _model.Car_id;
        dbParkingOrder.Parking_name = _model.Parking_name;
        dbParkingOrder.Total_price = _model.Total_price;
        dbParkingOrder.Hour_price = _model.Hour_price;
        dbParkingOrder.Hour = _model.Hour;
        dbParkingOrder.Free_hour = _model.Free_hour;
        dbParkingOrder.Payment_type = _model.Payment_type;
        dbParkingOrder.UpdatedAt = DateTime.UtcNow;
        _context.ParkingOrders.Update(dbParkingOrder);
        await _context.SaveChangesAsync();
    }
}

public class UpdateParkingOrderModel
{
    public UpdateParkingOrderModel()
    {
        
    }
    public UpdateParkingOrderModel(int user_id, int car_id, string? parking_name, decimal? total_price, decimal? hour_price, decimal? hour, decimal? free_hour, Payment? payment_type)
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