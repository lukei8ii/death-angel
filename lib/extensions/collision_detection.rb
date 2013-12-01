module Chingu
  module Traits
    module CollisionDetection

      def collides?(object2)
        if object2.is_a?(Hash)
          point_collision?(object2)
        elsif self.respond_to?(:bounding_box) && object2.respond_to?(:bounding_box)
          bounding_box_collision?(object2)
        elsif self.respond_to?(:radius) && object2.respond_to?(:radius)
          bounding_circle_collision?(object2)
        else
          bounding_box_bounding_circle_collision?(object2)
        end
      end

      def point_collision?(object2)
        return false unless self.collidable && !((object2.keys & [:x, :y]).empty?)
        self.collision_at?(object2[:x], object2[:y])
      end
    end
  end
end