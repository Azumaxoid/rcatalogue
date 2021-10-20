require 'securerandom'

class Greeter
  def initialize(name)
    @name = name.capitalize
  end

  def sockTag(uuid)
    for num in 1..11 do
      if rand(1..4) == 1
        puts 'INSERT INTO sock_tags VALUES ("'+uuid+'", "'+num.to_s+'");'
      end
    end
  end
  def salute
    uuid = SecureRandom.uuid
    puts 'INSERT INTO socks VALUES ("'+uuid+'", "Weave special", "Limited issue Weave socks.", 17.15, 33, "/catalogue/images/weave1.jpg", "/catalogue/images/weave2.jpg");'
    self.sockTag(uuid)
    uuid = SecureRandom.uuid
    puts 'INSERT INTO socks VALUES ("'+uuid+'", "Nerd leg", "For all those leg lovers out there. A perfect example of a swivel chair trained calf. Meticulously trained on a diet of sitting and Pina Coladas. Phwarr...", 7.99, 115, "/catalogue/images/bit_of_leg_1.jpeg", "/catalogue/images/bit_of_leg_2.jpeg");'
    self.sockTag(uuid)
    uuid = SecureRandom.uuid
    puts 'INSERT INTO socks VALUES ("'+uuid+'", "Crossed", "A mature sock, crossed, with an air of nonchalance.",  17.32, 738, "/catalogue/images/cross_1.jpeg", "/catalogue/images/cross_2.jpeg");'
    self.sockTag(uuid)
    uuid = SecureRandom.uuid
    puts 'INSERT INTO socks VALUES ("'+uuid+'", "SuperSport XL", "Ready for action. Engineers: be ready to smash that next bug! Be ready, with these super-action-sport-masterpieces. This particular engineer was chased away from the office with a stick.",  15.00, 820, "/catalogue/images/puma_1.jpeg", "/catalogue/images/puma_2.jpeg");'
    self.sockTag(uuid)
    uuid = SecureRandom.uuid
    puts 'INSERT INTO socks VALUES ("'+uuid+'", "Holy", "Socks fit for a Messiah. You too can experience walking in water with these special edition beauties. Each hole is lovingly proggled to leave smooth edges. The only sock approved by a higher power.",  99.99, 1, "/catalogue/images/holy_1.jpeg", "/catalogue/images/holy_2.jpeg");'
    self.sockTag(uuid)
    uuid = SecureRandom.uuid
    puts 'INSERT INTO socks VALUES ("'+uuid+'", "YouTube.sock", "We were not paid to sell this sock. It\'s just a bit geeky.",  10.99, 801, "/catalogue/images/youtube_1.jpeg", "/catalogue/images/youtube_2.jpeg");'
    self.sockTag(uuid)
    uuid = SecureRandom.uuid
    puts 'INSERT INTO socks VALUES ("'+uuid+'", "Figueroa", "enim officia aliqua excepteur esse deserunt quis aliquip nostrud anim",  14, 808, "/catalogue/images/WAT.jpg", "/catalogue/images/WAT2.jpg");'
    self.sockTag(uuid)
    uuid = SecureRandom.uuid
    puts 'INSERT INTO socks VALUES ("'+uuid+'", "Classic", "Keep it simple.",  12, 127, "/catalogue/images/classic.jpg", "/catalogue/images/classic2.jpg");'
    self.sockTag(uuid)
    uuid = SecureRandom.uuid
    puts 'INSERT INTO socks VALUES ("'+uuid+'", "Colourful", "proident occaecat irure et excepteur labore minim nisi amet irure",  18, 438, "/catalogue/images/colourful_socks.jpg", "/catalogue/images/colourful_socks.jpg");'
    self.sockTag(uuid)
    uuid = SecureRandom.uuid
    puts 'INSERT INTO socks VALUES ("'+uuid+'", "Cat socks", "consequat amet cupidatat minim laborum tempor elit ex consequat in",  15, 175, "/catalogue/images/catsocks.jpg", "/catalogue/images/catsocks2.jpg");'
    self.sockTag(uuid)

  end
end

# Create a new object
g = Greeter.new("world")

# Output "Hello World!"

for num in 1..100 do
  g.salute
end