using Microsoft.EntityFrameworkCore;

public class GetAllDebtQuery
{
    private readonly IUserDbContext _context;

    public GetAllDebtQuery(IUserDbContext context )
    {
        _context = context;
    }

    public async Task<List<Debt>> Handle()
    {
        var dbDebts = await _context.Depts.Include(u=> u.User).ToListAsync();
        if(dbDebts is null)
        {
            throw new InvalidOperationException("Borç Mevcut Değil!");
        } 
        return dbDebts;
    }
}