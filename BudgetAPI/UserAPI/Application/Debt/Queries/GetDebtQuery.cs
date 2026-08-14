using Microsoft.EntityFrameworkCore;

public class GetDebtQuery
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public GetDebtQuery(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task<Debt> Handle()
    {
        var dbDebt = await _context.Depts.Include(u=> u.User).FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbDebt is null)
        {
            throw new InvalidOperationException("Borç Mevcut Değil!");
        } 
        return dbDebt;
    }

}