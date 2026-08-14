using System.Security.Cryptography;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using Microsoft.EntityFrameworkCore;

public class CreateUserCommand
{
    private readonly IUserDbContext _context;
    private readonly CreateUserModel _model;

    public CreateUserCommand(IUserDbContext context, CreateUserModel model)
    {
        _context = context;
        _model = model;
    }

    public async Task Handle()
    {
        var dbUser = await _context.Users.FirstOrDefaultAsync(x=> x.Email == _model.Email);
        if(dbUser is not null)
        {
            throw new InvalidOperationException("Kullanıcı zaten mevut!");
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

public class CreateUserModel
{
    public CreateUserModel()
    {
        
    }
    public CreateUserModel(string? name, string? surname, string? email, string? password)
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