#include <string>
#include <memory>

template<typename... Args>
std::string sformatf(const std::string& format, Args&&... args)
{
    size_t nchars = snprintf(nullptr, 0, format.c_str(), std::forward<Args>(args)...) + 1;

    auto buf = std::make_unique<char[]>(nchars);
    assert (nchars == snprintf(buf.get(), nchars, format.c_str(), std::forward<Args>(args)...) + 1);

    return std::string(buf.get(), buf.get() + nchars);
}
