using Microsoft.EntityFrameworkCore;

public class DeleteDebtCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public DeleteDebtCommand(IUserDbContext context,int id)
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
        _context.Depts.Remove(dbDebt);
        
    }
}