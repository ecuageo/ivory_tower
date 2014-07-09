# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$}) { "spec" }
  watch(%r{^lib/ivory_tower/(.+)\.rb}) { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch(%r{^lib/ivory_tower/(.+)\.rb})      { |m| "spec/integration/*_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

