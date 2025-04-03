import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var soundEffectPlayer: AVAudioPlayer?
    
    
    private var musicVolume: Int = 7 {
        didSet {
            
            updateMusicPlayerVolume()
            
            UserDefaults.standard.set(musicVolume, forKey: musicVolumeKey)
        }
    }
    
    private var soundVolume: Int = 10 {
        didSet {
            
            UserDefaults.standard.set(soundVolume, forKey: soundVolumeKey)
        }
    }
    
    
    private(set) var isMusicPlaying = false
    private var musicWasPlayingBeforePause = false
    
    
    private let musicVolumeKey = "musicVolumeActual"
    private let soundVolumeKey = "soundVolumeActual"
    private let musicInitializedKey = "musicVolumeInitializedActual"
    private let soundInitializedKey = "soundVolumeInitializedActual"
    
    private init() {
        
        initializeDefaultValues()
        
        
        loadVolumeSettings()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    
    
    
    func getSoundVolume() -> Int {
        return soundVolume
    }
    
    
    func getMusicVolume() -> Int {
        return musicVolume
    }
    
    func setSoundVolume(_ value: Int) {
        soundVolume = value
    }
    
    func setMusicVolume(_ value: Int) {
        
        let previousVolume = musicVolume
        
        
        musicVolume = value
        
        
        if value == 0 {
            
            stopBackgroundMusic()
        } else if previousVolume == 0 && value > 0 {
            
            startBackgroundMusic()
        } else {
            
            updateMusicPlayerVolume()
        }
    }
    
    
    private func updateMusicPlayerVolume() {
        if let player = backgroundMusicPlayer {
            player.volume = normalizeVolume(musicVolume)
            
            
            if musicVolume == 0 {
                
                
                player.volume = 0
            }
        }
    }
    
    
    
    func startBackgroundMusic() {
        
        if musicVolume == 0 {
            return
        }
        
        
        if isMusicPlaying && backgroundMusicPlayer?.isPlaying == true {
            return
        }
        
        guard let url = Bundle.main.url(forResource: "sound-music-beat", withExtension: "mp3") else {
            print("Background music file not found")
            return
        }
        
        do {
            
            if backgroundMusicPlayer == nil {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                backgroundMusicPlayer?.numberOfLoops = -1 
                updateMusicPlayerVolume() 
                backgroundMusicPlayer?.prepareToPlay()
            }
            
            
            
            backgroundMusicPlayer?.play()
            isMusicPlaying = true
        } catch {
            print("Failed to play background music: \(error)")
        }
    }
    
    func pauseBackgroundMusic() {
        guard let player = backgroundMusicPlayer else { return }
        
        
        musicWasPlayingBeforePause = player.isPlaying
        
        if player.isPlaying {
            player.pause()
        }
    }
    
    func resumeBackgroundMusic() {
        guard let player = backgroundMusicPlayer, musicWasPlayingBeforePause else { return }
        
        player.play()
        isMusicPlaying = true
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
        isMusicPlaying = false
    }
    
    
    
    func playJumpSound() {
        
        if soundVolume == 0 {
            return
        }
        
        guard let url = Bundle.main.url(forResource: "sound-jump", withExtension: "mp3") else {
            print("Jump sound file not found")
            return
        }
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
            soundEffectPlayer?.volume = normalizeVolume(soundVolume)
            soundEffectPlayer?.prepareToPlay()
            soundEffectPlayer?.play()
        } catch {
            print("Failed to play jump sound: \(error)")
        }
    }
    
    
    
    private func initializeDefaultValues() {
        
        if !UserDefaults.standard.bool(forKey: soundInitializedKey) {
            UserDefaults.standard.set(10, forKey: soundVolumeKey)
            UserDefaults.standard.set(true, forKey: soundInitializedKey)
        }
        
        if !UserDefaults.standard.bool(forKey: musicInitializedKey) {
            UserDefaults.standard.set(7, forKey: musicVolumeKey)
            UserDefaults.standard.set(true, forKey: musicInitializedKey)
        }
    }
    
    private func loadVolumeSettings() {
        
        let savedMusicVolume = UserDefaults.standard.integer(forKey: musicVolumeKey)
        let savedSoundVolume = UserDefaults.standard.integer(forKey: soundVolumeKey)
        
        
        if savedMusicVolume >= 0 && savedMusicVolume <= 10 {
            
            self.musicVolume = savedMusicVolume
        }
        
        if savedSoundVolume >= 0 && savedSoundVolume <= 10 {
            
            self.soundVolume = savedSoundVolume
        }
        
        print("Loaded volumes - Music: \(musicVolume), Sound: \(soundVolume)")
    }
    
    
    private func normalizeVolume(_ value: Int) -> Float {
        
        if value == 0 {
            return 0.0
        }
        return Float(value) / 10.0
    }
    
    
    
    func handleAppDidEnterBackground() {
        pauseBackgroundMusic()
    }
    
    func handleAppWillEnterForeground() {
        resumeBackgroundMusic()
    }
}
