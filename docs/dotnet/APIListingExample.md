```C#
// This is an example of a SDK API listing

namespace Azure.Configuration {

    public class ConfigurationClient {
        public readonly ConfigurationClient.ConfigurationServiceOptions Options;
        
        public ConfigurationClient(string connectionString);
        public ConfigurationClient(string connectionString, ClientPipeline pipeline);
        
        public ClientPipeline Pipeline { get; }
        
        public Task<Response<ConfigurationSetting>> AddAsync(ConfigurationSetting setting, CancellationToken cancellation = default(CancellationToken));
        public Task<Response<ConfigurationSetting>> DeleteAsync(string key, SettingFilter filter = null, CancellationToken cancellation = default(CancellationToken));
        public Task<Response<ConfigurationSetting>> GetAsync(string key, SettingFilter filter = null, CancellationToken cancellation = default(CancellationToken));
        public Task<Response<SettingBatch>> GetBatchAsync(BatchFilter options, CancellationToken cancellation = default(CancellationToken));
        public Task<Response<ConfigurationSetting>> LockAsync(string key, SettingFilter filter = null, CancellationToken cancellation = default(CancellationToken));
        public Task<Response<ConfigurationSetting>> SetAsync(ConfigurationSetting setting, CancellationToken cancellation = default(CancellationToken));
        public Task<Response<ConfigurationSetting>> UnlockAsync(string key, SettingFilter filter = null, CancellationToken cancellation = default(CancellationToken));
        public Task<Response<ConfigurationSetting>> UpdateAsync(ConfigurationSetting setting, CancellationToken cancellation = default(CancellationToken));
        
        public struct ConfigurationServiceOptions {
            public ConfigurationServiceOptions(string apiVersion);
            public string ApplicationId { get; set; }
        }
    }
    
    public sealed class ConfigurationSetting {
        public ConfigurationSetting();
        public string ContentType { get; set; }
        public string ETag { get; set; }
        public string Key { get; set; }
        public string Label { get; set; }
        public DateTimeOffset LastModified { get; set; }
        public bool Locked { get; set; }
        public IDictionary<string, string> Tags { get; set; }
        public string Value { get; set; }
    }
    
    public class SettingBatch : IEnumerable, IEnumerable<ConfigurationSetting> {
        public SettingBatch();
        public int NextIndex { get; set; }
        public IEnumerator<ConfigurationSetting> GetEnumerator();
    }
    
    public enum SettingFields : uint {
        All = (uint)4294967295,
        ContentType = (uint)8,
        ETag = (uint)16,
        Key = (uint)1,
        Label = (uint)2,
        LastModified = (uint)32,
        Locked = (uint)64,
        None = (uint)0,
        Tags = (uint)128,
        Value = (uint)4,
    }
    
    public class SettingFilter {
        public SettingFilter();
        public ETagFilter ETag { get; set; }
        public SettingFields Fields { get; set; }
        public string Label { get; set; }
        public Nullable<DateTimeOffset> Revision { get; set; }
        public static implicit operator SettingFilter (string label);

    }
        public class BatchFilter : SettingFilter {
        public BatchFilter();
        public string Key { get; set; }
        public int StartIndex { get; set; }
    }
}
```