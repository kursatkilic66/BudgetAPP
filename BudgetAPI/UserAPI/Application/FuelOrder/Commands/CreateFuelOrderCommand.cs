using Microsoft.EntityFrameworkCore;

public class CreateFuelOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly CreateFuelOrderModel _model;

    public CreateFuelOrderCommand(IUserDbContext context, CreateFuelOrderModel model)
    {
        _context = context;
        _model = model;
    }

    public async Task Handle()
    {
        var dbFuel = await _context.FuelOrders.FirstOrDefaultAsync(x=>x.Total_price == _model.Total_price && x.Station == _model.Station);
        if(dbFuel is not null)
        {
            throw new InvalidOperationException("Akaryakıt İşlemi Zaten Mevcut!");
        }
        var fuel = new FuelOrder();
        fuel.User_id = _model.User_id;
        fuel.Car_id = _model.Car_id;
        fuel.Unit_price = _model.Unit_price;
        fuel.Total_price = _model.Total_price;
        fuel.Fuel_liter = _model.Fuel_liter;
        fuel.Station = _model.Station;
        fuel.OrderAt = DateTime.UtcNow;
        await _context.FuelOrders.AddAsync(fuel);
        await _context.SaveChangesAsync();
    }
}

public class CreateFuelOrderModel
{
    public CreateFuelOrderModel()
    {
        
    }
    public CreateFuelOrderModel(int user_id,int car_id, decimal? unit_price, decimal? total_price, decimal? fuel_liter, GasStation? station)
    {
        User_id = user_id;
        Car_id = car_id;
        Unit_price = unit_price;
        Total_price = total_price;
        Fuel_liter = fuel_liter;
        Station = station;
    }

    public int User_id { get; set; }
    public int Car_id { get; set; }
    public decimal? Unit_price { get; set; }
    public decimal? Total_price { get; set; }
    public decimal? Fuel_liter { get; set; }
    public GasStation? Station { get; set; }
}