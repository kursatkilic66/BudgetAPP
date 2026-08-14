using Microsoft.EntityFrameworkCore;

public class ActiveUserCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;
    public ActiveUserCommand(IUserDbContext context,int id)
    {
        _context = context;
        _id = id;
    }

    public async Task Handle()
    {
        var dbUser = await _context.Users.FirstOrDefaultAsync(x=>x.Id == _id);
        if(dbUser is null)
        {
            throw new InvalidOperationException("Kullanıcı mevcut değil!");
        }
        if(dbUser.IsPassived == false)
        {
            throw new InvalidOperationException("Kullanıcı zaten aktif!");
        }
        dbUser.IsPassived = false;
        dbUser.LastUpdate = DateTime.UtcNow;
        // await _context.Users.AddAsync(dbUser);
        _context.Users.Update(dbUser);
        await _context.SaveChangesAsync();
    }
}