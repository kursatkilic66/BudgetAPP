using Microsoft.EntityFrameworkCore;

public class UpdateCarItemCommand
{
    private readonly IUserDbContext _context;
    private readonly UpdateCarItemModel _model;
    private readonly int _id;

    public UpdateCarItemCommand(IUserDbContext context, UpdateCarItemModel model, int id)
    {
        _context = context;
        _model = model;
        _id = id;
    }

    public async Task Handle()
    {
        var dbCarItem = await _context.CarItems.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbCarItem is null)
        {
            throw new InvalidOperationException("Araç mevcut değil!");
        }
        dbCarItem.Item_name = _model.Item_name;
        dbCarItem.Item_amount = _model.Item_amount;
        dbCarItem.Item_price = _model.Item_price;
        dbCarItem.Item_description = _model.Item_description;
        dbCarItem.Car_id = _model.Car_id;
        dbCarItem.UpdatedAt = DateTime.UtcNow;
        _context.CarItems.Update(dbCarItem);
        await _context.SaveChangesAsync();
    }
}

public class UpdateCarItemModel
{
    public UpdateCarItemModel()
    {
        
    }
    public UpdateCarItemModel(string? ıtem_name, int? ıtem_amount, decimal? ıtem_price, string? ıtem_description, int? car_id)
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