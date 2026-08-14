using System.Security.Cryptography;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using Microsoft.EntityFrameworkCore;

public class UpdateUserCommand
{
    private readonly IUserDbContext _context;
    private readonly UpdateUserModel _model;
    private readonly int _id;

    public UpdateUserCommand(IUserDbContext context, UpdateUserModel model,int id)
    {
        _context = context;
        _model = model;
        _id = id;
    }

    public async Task Handle()
    {
        var dbUser =await _context.Users.FirstOrDefaultAsync(x=> x.Id == _id);
        if(dbUser is null)
        {
            throw new InvalidOperationException("Kullanıcı mevcut değil!");
        }
        if(_model.Password is null)
        {
            throw new InvalidOperationException("Şifre Boş Bırakılamaz!");
        }
        var user = new User();
        byte[] salt = RandomNumberGenerator.GetBytes(128/8);
        string hashed = Convert.ToBase64String(KeyDerivation.Pbkdf2(
            password: _model.Password,
            salt: salt,
            prf: KeyDerivationPrf.HMACSHA256,
            iterationCount: 100000,
            numBytesRequested: 256/8
        ));
        user.Name = _model.Name;
        user.Surname = _model.Surname;
        user.Email = _model.Email;
        user.Password = hashed;
        await _context.Users.AddAsync(user);
        await _context.SaveChangesAsync();
    }

}

public class UpdateUserModel
{
    public UpdateUserModel()
    {
        
    }
    public UpdateUserModel(string? name, string? surname, string? email, string? password)
    {
        Name = name;
        Surname = surname;
        Email = email;
        Password = password;
    }

    public string? Name { get; set; }
    public string? Surname { get; set; }
    public string? Email { get; set; }
    public string? Password { get; set; }
}