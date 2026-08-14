using Microsoft.EntityFrameworkCore;

public class CreateCarItemCommand
{
    private readonly IUserDbContext _context;
    private readonly CreateCarItemModel _model;

    public CreateCarItemCommand(IUserDbContext context, CreateCarItemModel model)
    {
        _context = context;
        _model = model;
    }
    public async Task Handle()
    {
        var dbCarItem = await _context.CarItems.FirstOrDefaultAsync(x=>x.Item_name == _model.Item_name);
        if(dbCarItem is not null)
        {
            throw new InvalidOperationException("Araç mevcut!");
        }
        var carItem = new CarItem();
        carItem.Item_name = _model.Item_name;
        carItem.Item_amount = _model.Item_amount;
        carItem.Item_price = _model.Item_price;
        carItem.Item_description = _model.Item_description;
        carItem.Car_id = _model.Car_id;
        carItem.CreatedAt = DateTime.UtcNow;
        await _context.CarItems.AddAsync(carItem);
        await _context.SaveChangesAsync();
    }
}

public class CreateCarItemModel
{
    public CreateCarItemModel()
    {
        
    }
    public CreateCarItemModel(string? ıtem_name, int? ıtem_amount, decimal? ıtem_price, string? ıtem_description, int? car_id)
    {
        Item_name = ıtem_name;
        Item_amount = ıtem_amount;
        Item_price = ıtem_price;
        Item_description = ıtem_description;
        Car_id = car_id;
    }

    public string? Item_name { get; set; }
    public int? Item_amount { get; set; }
    public decimal? Item_price { get; set; }
    public string? Item_description { get; set; }
    public int? Car_id { get; set; }
}