using System.ComponentModel.DataAnnotations.Schema;

public class ThemeSetting
{
    public ThemeSetting()
    {
        
    }
    public ThemeSetting(string? theme_mode, string? primary_color, string? currency, bool? notifications_enabled, string? language,int? user_id)
    {
        Theme_mode = theme_mode;
        Primary_color = primary_color;
        Currency = currency;
        Notifications_enabled = notifications_enabled;
        Language = language;
        User_id = user_id;
    }

    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }
    public int? User_id { get; set; }
    [ForeignKey("User_id")]
    public User? User { get; set; }
    public string? Theme_mode { get; set; } = "Dark";

    public string? Primary_color { get; set; } = "#3B82F6";

    public string? Currency { get; set; } = "TRY";

    public bool? Notifications_enabled { get; set; } = true;

    public string? Language { get; set; } = "tr";

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
}