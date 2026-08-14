using Microsoft.EntityFrameworkCore;

public class CreateDebtCommand
{
    private readonly IUserDbContext _context;
    private readonly CreateDebtModel _model;

    public CreateDebtCommand(IUserDbContext context, CreateDebtModel model)
    {
        _context = context;
        _model = model;
    }

    public async Task Handle()
    {
        var dbDebt = await _context.Depts.FirstOrDefaultAsync(x=>x.Debtor_name == _model.Debtor_name && x.Debt_amount == _model.Debt_amount);
        if(dbDebt is not null)
        {
            throw new InvalidOperationException("Borç zaten mevcut!");
        } 
        var debt = new Debt();
        debt.Debtor_name = _model.Debtor_name;
        debt.Debt_amount = _model.Debt_amount;
        debt.User_id = _model.User_id;
        debt.IsTaken = _model.IsTaken;
        debt.IsPayed = _model.IsPayed;
        await _context.Depts.AddAsync(debt);
        await _context.SaveChangesAsync();
    }
}

public class CreateDebtModel
{
    public CreateDebtModel()
    {
        
    }
    public CreateDebtModel(int? user_id, string? debtor_name, decimal? debt_amount, bool? ısPayed, bool? ısTaken)
    {
        User_id = user_id;
        Debtor_name = debtor_name;
        Debt_amount = debt_amount;
        IsPayed = ısPayed;
        IsTaken = ısTaken;
    }

    public int? User_id { get; set; }
    public string? Debtor_name { get; set; }
    public decimal? Debt_amount { get; set; }
    public bool? IsPayed { get; set; } = false;
    public bool? IsTaken { get; set; }
}