RSpec.describe Patterns::Form do
  after { Object.send(:remove_const, :CustomForm) if defined?(CustomForm) }

  it "includes Virtus.model" do
    CustomForm = Class.new(Patterns::Form)

    expect(CustomForm.attribute_set).to be_kind_of(Virtus::AttributeSet)
  end

  it "includes ActiveModel::Validations" do
    CustomForm = Class.new(Patterns::Form)

    expect(CustomForm).to be < ActiveModel::Validations
  end

  describe ".new" do
    it "returns form instance" do
      CustomForm = Class.new(Patterns::Form)

      form = CustomForm.new(double)

      expect(form).to be_a_kind_of(CustomForm)
    end

    it "assigns form attributes with values passed as second argument" do
      CustomForm = Class.new(Patterns::Form) do
        attribute :first_name, String
        attribute :last_name, String
      end

      form = CustomForm.new({ first_name: "Tony", last_name: "Stark" })

      expect(form.first_name).to eq "Tony"
      expect(form.last_name).to eq "Stark"
    end

    it "handles both symbols and strings as attribute keys" do
      CustomForm = Class.new(Patterns::Form) do
        attribute :first_name, String
        attribute :last_name, String
        attribute :email, String
        attribute :age, Integer
      end
      resource = double(
        attributes: {
          "first_name" => "Bat",
          last_name: "Man",
          "email" => "bat@man.dev"
        }
      )

      form = CustomForm.new(
        resource, { first_name: "Christian", "last_name" => "Bale", "age" => 40 }
      )

      expect(form.first_name).to eq "Christian"
      expect(form.last_name).to eq "Bale"
      expect(form.email).to eq "bat@man.dev"
      expect(form.age).to eq 40
    end

    context "if second parameter is ActionController::Parameters object" do
      it "treats ActionController::Parameters as regular hash" do
        CustomForm = Class.new(Patterns::Form) do
          attribute :first_name, String
          attribute :last_name, String
        end

        strong_parameters = ActionController::Parameters.new(
          { "first_name" => "Kobe", "last_name" => "Bryant" }
        )

        form = CustomForm.new(double, strong_parameters)

        expect(form.first_name).to eq "Kobe"
        expect(form.last_name).to eq "Bryant"
      end
    end

    context "if only parameter is ActionController::Parameters object" do
      it "treats ActionController::Parameters as regular hash" do
        CustomForm = Class.new(Patterns::Form) do
          attribute :first_name, String
          attribute :last_name, String
        end

        strong_parameters = ActionController::Parameters.new(
          { "first_name" => "Saul", "last_name" => "Goodman" }
        )

        form = CustomForm.new(strong_parameters)

        expect(form.first_name).to eq "Saul"
        expect(form.last_name).to eq "Goodman"
      end
    end

    it "can be initialized without providing resource" do
      CustomForm = Class.new(Patterns::Form)

      form = CustomForm.new

      expect(form).to be_a_kind_of(CustomForm)
    end

    context "when resource exists" do
      context "when resource responds to #attributes" do
        it "assigns merged attributes from resource and passed as argument" do
          CustomForm = Class.new(Patterns::Form) do
            attribute :first_name, String
            attribute :last_name, String
          end
          resource = double(attributes: { first_name: "Jack", last_name: "Black" })

          form = CustomForm.new(resource, { first_name: "Tony" })

          expect(form.first_name).to eq "Tony"
          expect(form.last_name).to eq "Black"
        end

        it "attempts to use public getters to populate missing attributes" do
          CustomForm = Class.new(Patterns::Form) do
            attribute :first_name, String
            attribute :last_name, String
            attribute :age, Integer
            attribute :email, String
          end
          resource = double(attributes: { first_name: "Jack", last_name: "Black" }, age: 27)

          form = CustomForm.new(resource, { first_name: "Tony" })

          expect(form.first_name).to eq "Tony"
          expect(form.last_name).to eq "Black"
          expect(form.age).to eq 27
          expect(form.email).to eq nil
        end
      end

      context "when resource does not respond to #attributes" do
        it "assigns attributes passed as arguments" do
          CustomForm = Class.new(Patterns::Form) do
            attribute :first_name, String
            attribute :last_name, String
          end

          form = CustomForm.new(double, { first_name: "Tony" })

          expect(form.first_name).to eq "Tony"
          expect(form.last_name).to eq nil
        end

        it "attempts to use public getters to populate missing attributes" do
          CustomForm = Class.new(Patterns::Form) do
            attribute :first_name, String
            attribute :last_name, String
            attribute :age, Integer
            attribute :email, String
          end
          resource = double(last_name: "Black", age: 27)

          form = CustomForm.new(resource, { first_name: "Tony" })

          expect(form.first_name).to eq "Tony"
          expect(form.last_name).to eq "Black"
          expect(form.age).to eq 27
          expect(form.email).to eq nil
        end
      end
    end
  end

  describe "#save" do
    context "when form is valid" do
      it "requires #persist method to be implemented" do
        CustomForm = Class.new(Patterns::Form)

        form = CustomForm.new(double)

        expect { form.save }.to raise_error NotImplementedError, "#persist has to be implemented"
      end

      it "returns result of #persist method" do
        CustomForm = Class.new(Patterns::Form) do
          private

          def persist
            10
          end
        end

        form = CustomForm.new(double)
        result = form.save

        expect(result).to eq 10
      end
    end

    context "when form is invalid" do
      it "does not call #persist method" do
        CustomForm = Class.new(Patterns::Form) do
          private

          def persist
            raise StandardError, "Should not be raised!"
          end
        end
        form = CustomForm.new(double)
        allow(form).to receive(:valid?) { false }

        expect { form.save }.to_not raise_error
      end

      it "returns false" do
        CustomForm = Class.new(Patterns::Form) do
          private

          def persist
            10
          end
        end
        form = CustomForm.new(double)
        allow(form).to receive(:valid?) { false }

        expect(form.save).to eq false
      end
    end
  end

  describe "#save!" do
    context "#save returned falsey value" do
      it "returns Pattern::Form::Invalid exception" do
        CustomForm = Class.new(Patterns::Form) do
          private

          def persist
            10
          end
        end
        form = CustomForm.new(double)
        allow(form).to receive(:save) { false }

        expect { form.save! }.to raise_error Patterns::Form::Invalid
      end
    end

    context "#save returned truthy value" do
      it "returns value returned from #save" do
        CustomForm = Class.new(Patterns::Form) do
          private

          def persist
            10
          end
        end
        form = CustomForm.new(double)

        expect(form.save!).to eq 10
      end
    end
  end

  describe "#as" do
    it "saves argument in @form_owner" do
      CustomForm = Class.new(Patterns::Form)
      form_owner = double("Form owner")

      form = CustomForm.new(double).as(form_owner)

      expect(form.instance_variable_get("@form_owner")).to eq form_owner
    end

    it "returns itself" do
      CustomForm = Class.new(Patterns::Form)

      form = CustomForm.new(double)
      result = form.as(double)

      expect(result).to eq form
    end
  end

  describe "#persisted?" do
    context "when resource is nil" do
      it "returns false" do
        CustomForm = Class.new(Patterns::Form)

        form = CustomForm.new

        expect(form.persisted?).to eq false
      end
    end

    context "when resource is not nil" do
      context "when resource responds to #persisted?" do
        it "returns resource#persisted?" do
          CustomForm = Class.new(Patterns::Form)

          form_1 = CustomForm.new(double(persisted?: true))
          form_2 = CustomForm.new(double(persisted?: false))

          expect(form_1.persisted?).to eq true
          expect(form_2.persisted?).to eq false
        end
      end

      context "when resource does not respond to #persisted?" do
        it "returns false" do
          CustomForm = Class.new(Patterns::Form)

          form = CustomForm.new(double)

          expect(form.persisted?).to eq false
        end
      end
    end
  end

  describe "#to_model" do
    it "returns itself" do
      CustomForm = Class.new(Patterns::Form)

      form = CustomForm.new(double)

      expect(form.to_model).to eq form
    end
  end

  describe "#to_partial_path" do
    it "returns nil" do
      CustomForm = Class.new(Patterns::Form)

      form = CustomForm.new(double)

      expect(form.to_partial_path).to eq nil
    end
  end

  describe "#to_key" do
    it "returns nil" do
      CustomForm = Class.new(Patterns::Form)

      form = CustomForm.new(double)

      expect(form.to_key).to eq nil
    end
  end

  describe "#to_param" do
    context "resource exists" do
      context "resource responds to #to_param" do
        it "returns resource#to_param" do
          CustomForm = Class.new(Patterns::Form)
          resource = double(to_param: 100)

          form = CustomForm.new(resource)

          expect(form.to_param).to eq 100
        end
      end
    end

    context "resource does not exist" do
      it "returns nil" do
        CustomForm = Class.new(Patterns::Form)

        form = CustomForm.new

        expect(form.to_param).to eq nil
      end
    end
  end

  describe "#model_name" do
    context "resource exists" do
      context "resource responds to #model_name" do
        context "param_key is not defined" do
          it "returns object's model name param_key, route_key and singular_route_key" do
            CustomForm = Class.new(Patterns::Form)
            resource = double(model_name: double(
              param_key: "resource_key",
              route_key: "resource_keys",
              singular_route_key: "resource_key"
            ))

            form = CustomForm.new(resource)
            result = form.model_name

            expect(result).to have_attributes(
              param_key: "resource_key",
              route_key: "resource_keys",
              singular_route_key: "resource_key"
            )
          end
        end

        context "param_key is defined" do
          it "returns param_key, route_key and singular_route_key derived from param key" do
            CustomForm = Class.new(Patterns::Form) do
              param_key "test_key"
            end
            resource = double(model_name: double(
              param_key: "resource_key",
              route_key: "resource_keys",
              singular_route_key: "resource_key"
            ))

            form = CustomForm.new(resource)
            result = form.model_name

            expect(result).to have_attributes(
              param_key: "test_key",
              route_key: "test_keys",
              singular_route_key: "test_key"
            )
          end
        end
      end

      context "resource does not respond to #model_name" do
        context "param_key is not defined" do
          it "raises NoParamKey" do
            CustomForm = Class.new(Patterns::Form)

            form = CustomForm.new(double)

            expect { form.model_name }.to raise_error(Patterns::Form::NoParamKey)
          end
        end

        context "param_key is defined" do
          it "returns param_key, route_key and singular_route_key derived from param key" do
            CustomForm = Class.new(Patterns::Form) do
              param_key "test_key"
            end

            form = CustomForm.new(double)
            result = form.model_name

            expect(result).to have_attributes(
              param_key: "test_key",
              route_key: "test_keys",
              singular_route_key: "test_key"
            )
          end
        end
      end
    end

    context "resource does not exist" do
      context "param_key is not defined" do
        it "raises NoParamKey" do
          CustomForm = Class.new(Patterns::Form)

          form = CustomForm.new

          expect { form.model_name }.to raise_error(Patterns::Form::NoParamKey)
        end
      end

      context "param_key is defined" do
        it "returns param_key, route_key and singular_route_key derived from param key" do
          CustomForm = Class.new(Patterns::Form) do
            param_key "test_key"
          end

          form = CustomForm.new
          result = form.model_name

          expect(result).to have_attributes(
            param_key: "test_key",
            route_key: "test_keys",
            singular_route_key: "test_key"
          )
        end
      end
    end
  end
end
