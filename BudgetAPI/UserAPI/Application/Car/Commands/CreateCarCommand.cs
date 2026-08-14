using Microsoft.EntityFrameworkCore;

public class CreateCarCommand
{
    private readonly IUserDbContext _context;
    private readonly CreateCarModel _model;

    public CreateCarCommand(IUserDbContext context, CreateCarModel model)
    {
        _context = context;
        _model = model;
    }

    public async Task Handle()
    {
        var dbCar = await _context.Cars.FirstOrDefaultAsync(x=> x.Model == _model.Model);
        if(dbCar is not null)
        {
            throw new InvalidOperationException("Araç mevcut!");
        }
        var car = new Car();
        car.Title = _model.Title;
        car.Brand = _model.Brand;
        car.Model = _model.Model;
        car.Year = _model.Year;
        car.Kilometer = _model.Kilometer;
        car.TankSize = _model.TankSize;
        car.User_id = _model.User_id;
        await _context.Cars.AddAsync(car);
        await _context.SaveChangesAsync();
    }
}

public class CreateCarModel
{
    public CreateCarModel()
    {
        
    }
    public CreateCarModel(string? title, string? brand, string? model, int? year, int? kilometer, int? tankSize,int? user_id)
    {
        Title = title;
        Brand = brand;
        Model = model;
        Year = year;
        Kilometer = kilometer;
        TankSize = tankSize;
        User_id = user_id;
    }

    public string? Title { get; set; }
    public string? Brand { get; set; }
    public string? Model { get; set; }
    public int? Year { get; set; }
    public int? Kilometer { get; set; }
    public int? TankSize { get; set; }
    public int? User_id { get; set; }

}