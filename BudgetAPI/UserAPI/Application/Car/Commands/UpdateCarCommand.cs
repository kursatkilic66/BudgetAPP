using Microsoft.EntityFrameworkCore;

public class UpdateCarCommand
{
    private readonly IUserDbContext _context;
    private readonly UpdateCarModel _model;
    private readonly int _id;

    public UpdateCarCommand(IUserDbContext context, UpdateCarModel model, int id)
    {
        _context = context;
        _model = model;
        _id = id;
    }

    public async Task Handle()
    {
        var dbCar = await _context.Cars.FirstOrDefaultAsync(x=> x.Id == _id);
        if(dbCar is null)
        {
            throw new InvalidOperationException("Araç mevcut değil!");
        }
        dbCar.Title = _model.Title;
        dbCar.Brand = _model.Brand;
        dbCar.Model = _model.Model;
        dbCar.Year = _model.Year;
        dbCar.Kilometer = _model.Kilometer;
        dbCar.TankSize = _model.TankSize;
        dbCar.User_id = _model.User_id;
        _context.Cars.Update(dbCar);
        await _context.SaveChangesAsync();
    }
}

public class UpdateCarModel
{
    public UpdateCarModel()
    {
        
    }
    public UpdateCarModel(string? title, string? brand, string? model, int? year, int? kilometer, int? tankSize,int? user_id)
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