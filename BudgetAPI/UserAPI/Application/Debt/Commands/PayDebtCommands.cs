using Microsoft.EntityFrameworkCore;

public class PayDebtCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public PayDebtCommand(IUserDbContext context,int id)
    {
        _context = context;
        _id = id;
    }

    public async Task Handle()
    {
        var dbDebt = await _context.Depts.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbDebt is null)
        {
            throw new InvalidOperationException("Borç Mevcut Değil!");
        } 
        dbDebt.IsPayed = true;
        dbDebt.UpdatedAt = DateTime.UtcNow;
        _context.Depts.Update(dbDebt);
        await _context.SaveChangesAsync();
    }
}