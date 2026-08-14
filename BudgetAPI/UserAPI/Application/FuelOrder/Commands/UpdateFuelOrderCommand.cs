using Microsoft.EntityFrameworkCore;

public class UpdateFuelOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly UpdateFuelOrderModel _model;
    private readonly int _id;

    public UpdateFuelOrderCommand(IUserDbContext context, UpdateFuelOrderModel model, int id)
    {
        _context = context;
        _model = model;
        _id = id;
    }

    public async Task Handle()
    {
        var dbFuel = await _context.FuelOrders.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbFuel is null)
        {
            throw new InvalidOperationException("Akaryakıt İşlemi Mevcut Değil!");
        }
        dbFuel.User_id = _model.User_id;
        dbFuel.Car_id = _model.Car_id;
        dbFuel.Unit_price = _model.Unit_price;
        dbFuel.Total_price = _model.Total_price;
        dbFuel.Fuel_liter = _model.Fuel_liter;
        dbFuel.Station = _model.Station;
        dbFuel.UpdateAt = DateTime.UtcNow;
        _context.FuelOrders.Update(dbFuel);
        await _context.SaveChangesAsync();
    }

}

public class UpdateFuelOrderModel
{
    public UpdateFuelOrderModel()
    {
        
    }
    public UpdateFuelOrderModel(int user_id,int car_id, decimal? unit_price, decimal? total_price, decimal? fuel_liter, GasStation? station)
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