using Microsoft.EntityFrameworkCore;

public class UpdateDebtCommand
{
    private readonly IUserDbContext _context;
    private readonly UpdateDebtModel _model;
    private readonly int _id;

    public UpdateDebtCommand(IUserDbContext context, UpdateDebtModel model, int id)
    {
        _context = context;
        _model = model;
        _id = id;
    }

    public async Task Handle()
    {
        var dbDebt = await _context.Depts.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbDebt is null)
        {
            throw new InvalidOperationException("Borç Mevcut Değil!");
        }
        dbDebt.Debtor_name = _model.Debtor_name;
        dbDebt.User_id = _model.User_id;
        dbDebt.Debt_amount = _model.Debt_amount;
        dbDebt.IsPayed = _model.IsPayed;
        dbDebt.IsTaken = _model.IsTaken;

        _context.Depts.Update(dbDebt);
        await _context.SaveChangesAsync(); 
    }

}

public class UpdateDebtModel
{
    public UpdateDebtModel()
    {
        
    }
    public UpdateDebtModel(int? user_id, string? debtor_name, decimal? debt_amount, bool? ısPayed, bool? ısTaken)
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