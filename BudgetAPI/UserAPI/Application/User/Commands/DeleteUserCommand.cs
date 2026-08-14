using Microsoft.EntityFrameworkCore;

public class DeleteUserCommand
{
    private readonly IUserDbContext _context;
    private readonly int _id;

    public DeleteUserCommand(IUserDbContext context, int id)
    {
        _context = context;
        _id = id;
    }

    public async Task Handle()
    {
        var dbUser = await _context.Users.FirstOrDefaultAsync(x => x.Id == _id);
        if(dbUser is null)
        {
            throw new InvalidOperationException("Kullanıcı mevcut değil!");
        }
        if(dbUser.IsPassived == true)
        {
            throw new InvalidOperationException("Kullanıcı zaten pasif!");
        }
        dbUser.PassivedAt = DateTime.UtcNow;
        await _context.SaveChangesAsync();
    }
}