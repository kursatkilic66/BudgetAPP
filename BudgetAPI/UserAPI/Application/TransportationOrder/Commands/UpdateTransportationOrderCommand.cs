using Microsoft.EntityFrameworkCore;

public class UpdateTransportationOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly UpdateTransportationOrderModel _model;
    private readonly int _id;

    public UpdateTransportationOrderCommand(IUserDbContext context, UpdateTransportationOrderModel model,int id)
    {
        _context = context;
        _model = model;
        _id = id;
    }
    public async Task Handle()
    {
        var dbItem = await _context.TransportationOrders.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbItem is null)
        {
            throw new InvalidOperationException("Böyle bir harcama yok!");
        }
        dbItem.Name = _model.Name;
        dbItem.Amount = _model.Amount;
        dbItem.User_id = _model.User_id;
        dbItem.UpdatedAt = DateTime.UtcNow;
        _context.TransportationOrders.Update(dbItem);
        await _context.SaveChangesAsync();
    }
}

public class UpdateTransportationOrderModel
{
    public UpdateTransportationOrderModel()
    {
        
    }
    public UpdateTransportationOrderModel(string? name, decimal? amount,int? user_id)
    {
        Name = name;
        Amount = amount;
        User_id = user_id;
    }

    public string? Name { get; set; }
    public decimal? Amount { get; set; }
    public int? User_id { get; set; }
}