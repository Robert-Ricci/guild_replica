class StudentsController < ApplicationController
    before_action :require_login, only: [:show, :edit, :update]

    def home

    end

    def show
        @student = Student.find_by(id: params[:id])
    end


    def new
        @student = Student.new
    end

    def create
        @student = Student.new(student_params)
        if @student.save
            session[:student_id] = @student.id
            redirect_to student_path(@student), notice: "User Successfully Created!"
        else
            render :new, alert: "Missing Fields, Please Try Again."
        end
    end

    def edit
        @student = Student.find_by(id: params[:id])
    end

    def update
        @student = Student.find_by(id: params[:id])
        @student.update(student_params)
        if @student.save
            redirect_to student_path(@student), notice: "Successfully Updated!"
            # flash[:notice] = "Successfully Updated"
        else
            render :edit, alert: "Missing Fields, Please Try Again!"
        end

    end

    private

    def student_params
        params.require(:student).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation)
    end
end
