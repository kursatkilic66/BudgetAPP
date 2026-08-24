using Microsoft.EntityFrameworkCore;

public class CreateTransportationOrderCommand
{
    private readonly IUserDbContext _context;
    private readonly CreateTransportationOrderModel _model;

    public CreateTransportationOrderCommand(IUserDbContext context, CreateTransportationOrderModel model)
    {
        _context = context;
        _model = model;
    }
    public async Task Handle()
    {
        if(_model is not null)
        {
            var item = new TransportationOrder();
            item.Name = _model.Name;
            item.Amount = _model.Amount;
            item.User_id = _model.User_id;
            await _context.TransportationOrders.AddAsync(item);
            await _context.SaveChangesAsync();
        }
        else
        {
            throw new InvalidOperationException("Gönderilen içerik boş olamaz!");
        }
    }
}

public class CreateTransportationOrderModel
{
    public CreateTransportationOrderModel()
    {
        
    }
    public CreateTransportationOrderModel(string? name, decimal? amount,int? user_id)
    {
        Name = name;
        Amount = amount;
        User_id = user_id;
    }

    public string? Name { get; set; }
    public int? User_id { get; set; }
    public decimal? Amount { get; set; }
}